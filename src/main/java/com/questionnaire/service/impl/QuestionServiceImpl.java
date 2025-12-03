package com.questionnaire.service.impl;

import com.questionnaire.dao.QuestionMapper;
import com.questionnaire.dao.QuestionOptionMapper;
import com.questionnaire.model.Question;
import com.questionnaire.service.QuestionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class QuestionServiceImpl implements QuestionService {

    @Autowired
    private QuestionMapper questionMapper;
    
    @Autowired
    private QuestionOptionMapper optionMapper;

    @Override
    public Question findById(Integer id) {
        return questionMapper.findById(id);
    }

    @Override
    public List<Question> findByQuestionnaireId(Integer questionnaireId) {
        return questionMapper.findByQuestionnaireId(questionnaireId);
    }

    @Override
    @Transactional
    public boolean create(Question question) {
        return questionMapper.insert(question) > 0;
    }

    @Override
    @Transactional
    public boolean update(Question question) {
        return questionMapper.update(question) > 0;
    }

    @Override
    @Transactional
    public boolean deleteById(Integer id) {
        // 级联删除选项
        optionMapper.deleteByQuestionId(id);
        return questionMapper.deleteById(id) > 0;
    }

    @Override
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
