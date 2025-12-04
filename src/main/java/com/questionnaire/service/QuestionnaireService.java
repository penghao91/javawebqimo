package com.questionnaire.service;

import com.questionnaire.dao.QuestionnaireDao;
import com.questionnaire.dao.QuestionDao;
import com.questionnaire.dao.QuestionOptionDao;
import com.questionnaire.model.Questionnaire;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;
import java.util.Date;
import java.util.Calendar;

@Service
public class QuestionnaireService {

    @Resource
    private QuestionnaireDao questionnaireDao;
    
    @Resource
    private QuestionDao questionDao;
    
    @Resource
    private QuestionOptionDao optionDao;

    public Questionnaire findById(Integer id) {
        return questionnaireDao.findById(id);
    }

    public List<Questionnaire> findByUserId(Integer userId) {
        return questionnaireDao.findByUserId(userId);
    }

    public List<Questionnaire> findAll() {
        return questionnaireDao.findAll();
    }
    
    public List<Questionnaire> findActiveByUserId(Integer userId) {
        return questionnaireDao.findActiveByUserId(userId);
    }
    
    public List<Questionnaire> findStarredByUserId(Integer userId) {
        return questionnaireDao.findStarredByUserId(userId);
    }
    
    public List<Questionnaire> findAllStarred() {
        return questionnaireDao.findAllStarred();
    }
    
    public List<Questionnaire> findDeletedByUserId(Integer userId) {
        return questionnaireDao.findDeletedByUserId(userId);
    }
    
    public List<Questionnaire> findAllDeleted() {
        return questionnaireDao.findAllDeleted();
    }
    
    public List<Questionnaire> findByFolderId(Integer folderId) {
        return questionnaireDao.findByFolderId(folderId);
    }

    @Transactional
    public boolean create(Questionnaire questionnaire) {
        return questionnaireDao.insert(questionnaire) > 0;
    }

    @Transactional
    public boolean update(Questionnaire questionnaire) {
        return questionnaireDao.update(questionnaire) > 0;
    }

    @Transactional
    public boolean deleteById(Integer id, Integer userId) {
        if (!isOwner(id, userId)) {
            return false;
        }
        // 级联删除问题和选项
        questionDao.deleteByQuestionnaireId(id);
        return questionnaireDao.deleteById(id) > 0;
    }

    @Transactional
    public boolean publish(Integer id, Integer userId) {
        if (!isOwner(id, userId)) {
            return false;
        }
        return questionnaireDao.updateStatus(id, 2) > 0;
    }

    public boolean isOwner(Integer questionnaireId, Integer userId) {
        Questionnaire q = findById(questionnaireId);
        return q != null && q.getCreatedBy().equals(userId);
    }
    
    @Transactional
    public boolean star(Integer id, Integer userId) {
        if (!isOwner(id, userId)) {
            return false;
        }
        return questionnaireDao.updateStarred(id, 1) > 0;
    }
    
    @Transactional
    public boolean unstar(Integer id, Integer userId) {
        if (!isOwner(id, userId)) {
            return false;
        }
        return questionnaireDao.updateStarred(id, 0) > 0;
    }
    
    @Transactional
    public boolean softDelete(Integer id, Integer userId) {
        if (!isOwner(id, userId)) {
            return false;
        }
        return questionnaireDao.updateDeleted(id, 1, new Date()) > 0;
    }
    
    @Transactional
    public boolean restore(Integer id, Integer userId) {
        if (!isOwner(id, userId)) {
            return false;
        }
        return questionnaireDao.updateDeleted(id, 0, null) > 0;
    }
    
    @Transactional
    public void autoDeleteExpired(Integer days) {
        // 计算过期时间
        Calendar cal = Calendar.getInstance();
        cal.add(Calendar.DAY_OF_YEAR, -days);
        Date expireTime = cal.getTime();
        
        // 查询已过期的已删除问卷
        List<Questionnaire> expiredQuestionnaires = questionnaireDao.findExpiredDeleted(expireTime);
        
        // 永久删除这些问卷
        for (Questionnaire q : expiredQuestionnaires) {
            // 级联删除相关问题
            questionDao.deleteByQuestionnaireId(q.getId());
            // 永久删除问卷
            questionnaireDao.deleteById(q.getId());
        }
    }
    
    @Transactional
    public boolean deletePermanently(Integer id, Integer userId) {
        if (!isOwner(id, userId)) {
            return false;
        }
        
        Questionnaire q = findById(id);
        if (q == null || q.getIsDeleted() == 0) {
            return false; // 只能永久删除已软删除的问卷
        }
        
        // 级联删除相关问题
        questionDao.deleteByQuestionnaireId(id);
        
        // 永久删除问卷
        return questionnaireDao.deleteById(id) > 0;
    }
}