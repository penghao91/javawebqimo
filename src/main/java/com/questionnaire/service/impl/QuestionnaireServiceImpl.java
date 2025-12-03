package com.questionnaire.service.impl;

import com.questionnaire.dao.QuestionnaireMapper;
import com.questionnaire.dao.QuestionMapper;
import com.questionnaire.dao.QuestionOptionMapper;
import com.questionnaire.model.Questionnaire;
import com.questionnaire.service.QuestionnaireService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class QuestionnaireServiceImpl implements QuestionnaireService {

    @Autowired
    private QuestionnaireMapper questionnaireMapper;
    
    @Autowired
    private QuestionMapper questionMapper;
    
    @Autowired
    private QuestionOptionMapper optionMapper;

    @Override
    public Questionnaire findById(Integer id) {
        return questionnaireMapper.findById(id);
    }

    @Override
    public List<Questionnaire> findByUserId(Integer userId) {
        return questionnaireMapper.findByUserId(userId);
    }

    @Override
    public List<Questionnaire> findAll() {
        return questionnaireMapper.findAll();
    }

    @Override
    @Transactional
    public boolean create(Questionnaire questionnaire) {
        return questionnaireMapper.insert(questionnaire) > 0;
    }

    @Override
    @Transactional
    public boolean update(Questionnaire questionnaire) {
        return questionnaireMapper.update(questionnaire) > 0;
    }

    @Override
    @Transactional
    public boolean deleteById(Integer id, Integer userId) {
        if (!isOwner(id, userId)) {
            return false;
        }
        // 级联删除问题和选项
        questionMapper.deleteByQuestionnaireId(id);
        return questionnaireMapper.deleteById(id) > 0;
    }

    @Override
    @Transactional
    public boolean publish(Integer id, Integer userId) {
        if (!isOwner(id, userId)) {
            return false;
        }
        return questionnaireMapper.updateStatus(id, 2) > 0;
    }

    @Override
    public boolean isOwner(Integer questionnaireId, Integer userId) {
        Questionnaire q = findById(questionnaireId);
        return q != null && q.getCreatedBy().equals(userId);
    }
}
