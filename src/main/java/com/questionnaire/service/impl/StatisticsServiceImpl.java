package com.questionnaire.service.impl;

import com.questionnaire.dao.AnswerDetailMapper;
import com.questionnaire.dao.AnswerMapper;
import com.questionnaire.dao.QuestionMapper;
import com.questionnaire.dao.QuestionOptionMapper;
import com.questionnaire.model.Question;
import com.questionnaire.model.QuestionOption;
import com.questionnaire.service.StatisticsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.*;

@Service
public class StatisticsServiceImpl implements StatisticsService {

    @Autowired
    private AnswerMapper answerMapper;
    
    @Autowired
    private AnswerDetailMapper answerDetailMapper;
    
    @Autowired
    private QuestionMapper questionMapper;
    
    @Autowired
    private QuestionOptionMapper optionMapper;

    @Override
    public Map<String, Object> getQuestionnaireStatistics(Integer questionnaireId) {
        Map<String, Object> result = new HashMap<>();
        
        // 总提交数量
        int totalSubmissions = answerMapper.countByQuestionnaireId(questionnaireId);
        result.put("totalSubmissions", totalSubmissions);
        
        // 获取所有问题
        List<Question> questions = questionMapper.findByQuestionnaireId(questionnaireId);
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

    @Override
    public List<Map<String, Object>> getQuestionStatistics(Integer questionId) {
        List<Map<String, Object>> result = new ArrayList<>();
        
        Question question = questionMapper.findById(questionId);
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
        List<QuestionOption> options = optionMapper.findByQuestionId(questionId);
        
        for (QuestionOption option : options) {
            Map<String, Object> optionStat = new HashMap<>();
            optionStat.put("optionText", option.getOptionText());
            
            // 统计选择该选项的次数
            int count = answerDetailMapper.countByQuestionAndAnswer(questionId, option.getOptionText());
            optionStat.put("count", count);
            
            result.add(optionStat);
        }
        
        return result;
    }
}
