package com.questionnaire.service;

import com.questionnaire.dao.AnswerMapper;
import com.questionnaire.dao.AnswerDetailMapper;
import com.questionnaire.dao.QuestionMapper;
import com.questionnaire.model.Answer;
import com.questionnaire.model.AnswerDetail;
import com.questionnaire.model.Question;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.Enumeration;
import java.util.List;

@Service
public class AnswerService {

    @Resource
    private AnswerMapper answerMapper;
    
    @Resource
    private AnswerDetailMapper answerDetailMapper;
    
    @Resource
    private QuestionMapper questionMapper;

    public Answer findById(Integer id) {
        return answerMapper.findById(id);
    }

    public List<Answer> findByQuestionnaireId(Integer questionnaireId) {
        return answerMapper.findByQuestionnaireId(questionnaireId);
    }

    public int countByQuestionnaireId(Integer questionnaireId) {
        return answerMapper.countByQuestionnaireId(questionnaireId);
    }

    @Transactional
    public boolean submitAnswer(Integer questionnaireId, HttpServletRequest request) {
        try {
            // 创建答题记录
            Answer answer = new Answer();
            answer.setQuestionnaireId(questionnaireId);
            answer.setIpAddress(request.getRemoteAddr());
            
            // TODO: 如果用户已登录，设置userId
            // answer.setUserId(userId);
            
            answerMapper.insert(answer);
            
            // 获取所有问题
            List<Question> questions = questionMapper.findByQuestionnaireId(questionnaireId);
            
            // 处理每个问题的答案
            for (Question question : questions) {
                String paramName = "question_" + question.getId();
                String[] values = request.getParameterValues(paramName);
                
                if (values != null && values.length > 0) {
                    String answerText = String.join(",", values);
                    
                    AnswerDetail detail = new AnswerDetail();
                    detail.setAnswerId(answer.getId());
                    detail.setQuestionId(question.getId());
                    detail.setAnswerText(answerText);
                    
                    answerDetailMapper.insert(detail);
                }
            }
            
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}