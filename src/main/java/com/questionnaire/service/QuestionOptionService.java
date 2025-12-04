package com.questionnaire.service;

import com.questionnaire.dao.QuestionOptionMapper;
import com.questionnaire.model.QuestionOption;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;

@Service
public class QuestionOptionService {

    @Resource
    private QuestionOptionMapper optionMapper;

    public QuestionOption findById(Integer id) {
        return optionMapper.findById(id);
    }

    public List<QuestionOption> findByQuestionId(Integer questionId) {
        return optionMapper.findByQuestionId(questionId);
    }

    @Transactional
    public boolean create(QuestionOption option) {
        return optionMapper.insert(option) > 0;
    }

    @Transactional
    public boolean update(QuestionOption option) {
        return optionMapper.update(option) > 0;
    }

    @Transactional
    public boolean deleteById(Integer id) {
        return optionMapper.deleteById(id) > 0;
    }

    @Transactional
    public boolean deleteByQuestionId(Integer questionId) {
        return optionMapper.deleteByQuestionId(questionId) > 0;
    }
}