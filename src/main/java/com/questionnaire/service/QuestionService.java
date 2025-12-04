package com.questionnaire.service;

import com.questionnaire.dao.QuestionMapper;
import com.questionnaire.dao.QuestionOptionMapper;
import com.questionnaire.model.Question;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;

@Service
public class QuestionService {

    @Resource
    private QuestionMapper questionMapper;
    
    @Resource
    private QuestionOptionMapper optionMapper;

    public Question findById(Integer id) {
        return questionMapper.findById(id);
    }

    public List<Question> findByQuestionnaireId(Integer questionnaireId) {
        return questionMapper.findByQuestionnaireId(questionnaireId);
    }

    @Transactional
    public boolean create(Question question) {
        return questionMapper.insert(question) > 0;
    }

    @Transactional
    public boolean update(Question question) {
        return questionMapper.update(question) > 0;
    }

    @Transactional
    public boolean deleteById(Integer id) {
        // 级联删除选项
        optionMapper.deleteByQuestionId(id);
        return questionMapper.deleteById(id) > 0;
    }

    @Transactional
    public boolean deleteByQuestionnaireId(Integer questionnaireId) {
        // 先删除所有问题的选项
        List<Question> questions = findByQuestionnaireId(questionnaireId);
        for (Question question : questions) {
            optionMapper.deleteByQuestionId(question.getId());
        }
        return questionMapper.deleteByQuestionnaireId(questionnaireId) > 0;
    }
}