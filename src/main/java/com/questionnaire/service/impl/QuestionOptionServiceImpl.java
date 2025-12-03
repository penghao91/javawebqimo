package com.questionnaire.service.impl;

import com.questionnaire.dao.QuestionOptionMapper;
import com.questionnaire.model.QuestionOption;
import com.questionnaire.service.QuestionOptionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class QuestionOptionServiceImpl implements QuestionOptionService {

    @Autowired
    private QuestionOptionMapper optionMapper;

    @Override
    public QuestionOption findById(Integer id) {
        return optionMapper.findById(id);
    }

    @Override
    public List<QuestionOption> findByQuestionId(Integer questionId) {
        return optionMapper.findByQuestionId(questionId);
    }

    @Override
    @Transactional
    public boolean create(QuestionOption option) {
        return optionMapper.insert(option) > 0;
    }

    @Override
    @Transactional
    public boolean update(QuestionOption option) {
        return optionMapper.update(option) > 0;
    }

    @Override
    @Transactional
    public boolean deleteById(Integer id) {
        return optionMapper.deleteById(id) > 0;
    }

    @Override
    @Transactional
    public boolean deleteByQuestionId(Integer questionId) {
        return optionMapper.deleteByQuestionId(questionId) > 0;
    }
}
