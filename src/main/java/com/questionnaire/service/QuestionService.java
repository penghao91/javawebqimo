package com.questionnaire.service;

import com.questionnaire.dao.QuestionDao;
import com.questionnaire.dao.QuestionOptionDao;
import com.questionnaire.model.Question;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;

@Service
public class QuestionService {

    @Resource
    private QuestionDao questionDao;
    
    @Resource
    private QuestionOptionDao optionDao;

    public Question findById(Integer id) {
        return questionDao.findById(id);
    }

    public List<Question> findByQuestionnaireId(Integer questionnaireId) {
        return questionDao.findByQuestionnaireId(questionnaireId);
    }

    @Transactional
    public boolean create(Question question) {
        return questionDao.insert(question) > 0;
    }

    @Transactional
    public boolean update(Question question) {
        return questionDao.update(question) > 0;
    }

    @Transactional
    public boolean deleteById(Integer id) {
        // 级联删除选项
        optionDao.deleteByQuestionId(id);
        return questionDao.deleteById(id) > 0;
    }

    @Transactional
    public boolean deleteByQuestionnaireId(Integer questionnaireId) {
        // 先删除所有问题的选项
        List<Question> questions = findByQuestionnaireId(questionnaireId);
        for (Question question : questions) {
            optionDao.deleteByQuestionId(question.getId());
        }
        return questionDao.deleteByQuestionnaireId(questionnaireId) > 0;
    }
}