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
import java.util.Date;
import java.util.Calendar;

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
    public List<Questionnaire> findActiveByUserId(Integer userId) {
        return questionnaireMapper.findActiveByUserId(userId);
    }
    
    @Override
    public List<Questionnaire> findStarredByUserId(Integer userId) {
        return questionnaireMapper.findStarredByUserId(userId);
    }
    
    @Override
    public List<Questionnaire> findDeletedByUserId(Integer userId) {
        return questionnaireMapper.findDeletedByUserId(userId);
    }
    
    @Override
    public List<Questionnaire> findByFolderId(Integer folderId) {
        return questionnaireMapper.findByFolderId(folderId);
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
    
    @Override
    @Transactional
    public boolean star(Integer id, Integer userId) {
        if (!isOwner(id, userId)) {
            return false;
        }
        return questionnaireMapper.updateStarred(id, 1) > 0;
    }
    
    @Override
    @Transactional
    public boolean unstar(Integer id, Integer userId) {
        if (!isOwner(id, userId)) {
            return false;
        }
        return questionnaireMapper.updateStarred(id, 0) > 0;
    }
    
    @Override
    @Transactional
    public boolean softDelete(Integer id, Integer userId) {
        if (!isOwner(id, userId)) {
            return false;
        }
        return questionnaireMapper.updateDeleted(id, 1, new Date()) > 0;
    }
    
    @Override
    @Transactional
    public boolean restore(Integer id, Integer userId) {
        if (!isOwner(id, userId)) {
            return false;
        }
        return questionnaireMapper.updateDeleted(id, 0, null) > 0;
    }
    
    @Override
    @Transactional
    public void autoDeleteExpired(Integer days) {
        // 计算过期时间
        Calendar cal = Calendar.getInstance();
        cal.add(Calendar.DAY_OF_YEAR, -days);
        Date expireTime = cal.getTime();
        
        // 查询已过期的已删除问卷
        List<Questionnaire> expiredQuestionnaires = questionnaireMapper.findExpiredDeleted(expireTime);
        
        // 永久删除这些问卷
        for (Questionnaire q : expiredQuestionnaires) {
            // 级联删除相关问题
            questionMapper.deleteByQuestionnaireId(q.getId());
            // 永久删除问卷
            questionnaireMapper.deleteById(q.getId());
        }
    }
}
