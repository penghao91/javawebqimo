package com.questionnaire.service;

import com.questionnaire.dao.AnswerDetailDao;
import com.questionnaire.dao.AnswerDao;
import com.questionnaire.dao.QuestionDao;
import com.questionnaire.dao.QuestionOptionDao;
import com.questionnaire.model.Question;
import com.questionnaire.model.QuestionOption;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.*;

@Service
public class StatisticsService {

    @Resource
    private AnswerDao answerDao;
    
    @Resource
    private AnswerDetailDao answerDetailDao;
    
    @Resource
    private QuestionDao questionDao;
    
    @Resource
    private QuestionOptionDao optionDao;

    public Map<String, Object> getQuestionnaireStatistics(Integer questionnaireId) {
        Map<String, Object> result = new HashMap<>();
        
        // 总提交数量
        int totalSubmissions = answerDao.countByQuestionnaireId(questionnaireId);
        result.put("totalSubmissions", totalSubmissions);
        
        // 获取所有问题
        List<Question> questions = questionDao.findByQuestionnaireId(questionnaireId);
        List<Map<String, Object>> questionStats = new ArrayList<>();
        
        for (Question question : questions) {
            Map<String, Object> qStat = new HashMap<>();
            qStat.put("questionId", question.getId());
            qStat.put("questionText", question.getQuestionText());
            qStat.put("questionType", question.getQuestionType());
            qStat.put("typeDesc", question.getTypeDesc());
            
            // 获取问题统计
            List<Map<String, Object>> optionStats = getQuestionStatistics(question.getId());
            qStat.put("optionStats", optionStats);
            
            questionStats.add(qStat);
        }
        
        result.put("questionStats", questionStats);
        return result;
    }

    public List<Map<String, Object>> getQuestionStatistics(Integer questionId) {
        List<Map<String, Object>> result = new ArrayList<>();
        
        Question question = questionDao.findById(questionId);
        if (question == null) {
            return result;
        }
        
        // 简答题：返回文本列表
        if (question.getQuestionType() == 3) {
            // 获取所有文本答案
            // 这里简化处理，实际应该查询answer_detail表
            Map<String, Object> textStat = new HashMap<>();
            textStat.put("type", "text");
            result.add(textStat);
            return result;
        }
        
        // 选择题：统计每个选项的选择次数
        List<QuestionOption> options = optionDao.findByQuestionId(questionId);
        
        for (QuestionOption option : options) {
            Map<String, Object> optionStat = new HashMap<>();
            optionStat.put("optionText", option.getOptionText());
            
            // 统计选择该选项的次数
            int count = answerDetailDao.countByQuestionAndAnswer(questionId, option.getOptionText());
            optionStat.put("count", count);
            
            result.add(optionStat);
        }
        
        return result;
    }
}