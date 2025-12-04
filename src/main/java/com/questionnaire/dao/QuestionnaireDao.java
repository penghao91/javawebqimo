package com.questionnaire.dao;

import com.questionnaire.model.Questionnaire;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;
import java.util.List;
import java.util.Date;

@Repository
public interface QuestionnaireDao {
    
    Questionnaire findById(Integer id);
    
    List<Questionnaire> findByUserId(Integer userId);
    
    List<Questionnaire> findAll();
    
    int insert(Questionnaire questionnaire);
    
    int update(Questionnaire questionnaire);
    
    int deleteById(Integer id);
    
    int updateStatus(@Param("id") Integer id, @Param("status") Integer status);
    
    int updateStarred(@Param("id") Integer id, @Param("isStarred") Integer isStarred);
    
    int updateDeleted(@Param("id") Integer id, @Param("isDeleted") Integer isDeleted, @Param("deletedTime") Date deletedTime);
    
    List<Questionnaire> findExpiredDeleted(Date expireTime);
    
    int updateFolder(@Param("id") Integer id, @Param("folderId") Integer folderId);
    
    List<Questionnaire> findActiveByUserId(Integer userId);
    
    List<Questionnaire> findStarredByUserId(Integer userId);
    
    List<Questionnaire> findAllStarred();
    
    List<Questionnaire> findDeletedByUserId(Integer userId);
    
    List<Questionnaire> findAllDeleted();
    
    List<Questionnaire> findByFolderId(Integer folderId);
}