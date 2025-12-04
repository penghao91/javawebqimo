package com.questionnaire.service;

import com.questionnaire.dao.QuestionOptionDao;
import com.questionnaire.model.QuestionOption;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;

@Service
public class QuestionOptionService {

    @Resource
    private QuestionOptionDao optionDao;

    public QuestionOption findById(Integer id) {
        return optionDao.findById(id);
    }

    public List<QuestionOption> findByQuestionId(Integer questionId) {
        return optionDao.findByQuestionId(questionId);
    }

    @Transactional
    public boolean create(QuestionOption option) {
        return optionDao.insert(option) > 0;
    }

    @Transactional
    public boolean update(QuestionOption option) {
        return optionDao.update(option) > 0;
    }

    @Transactional
    public boolean deleteById(Integer id) {
        return optionDao.deleteById(id) > 0;
    }

    @Transactional
    public boolean deleteByQuestionId(Integer questionId) {
        return optionDao.deleteByQuestionId(questionId) > 0;
    }
}