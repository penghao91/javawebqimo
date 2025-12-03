package com.questionnaire.service;

import com.questionnaire.model.Questionnaire;
import java.util.List;

public interface QuestionnaireService {
    Questionnaire findById(Integer id);
    List<Questionnaire> findByUserId(Integer userId);
    List<Questionnaire> findAll();
    List<Questionnaire> findActiveByUserId(Integer userId);
    List<Questionnaire> findStarredByUserId(Integer userId);
    List<Questionnaire> findDeletedByUserId(Integer userId);
    List<Questionnaire> findByFolderId(Integer folderId);
    boolean create(Questionnaire questionnaire);
    boolean update(Questionnaire questionnaire);
    boolean deleteById(Integer id, Integer userId);
    boolean publish(Integer id, Integer userId);
    boolean isOwner(Integer questionnaireId, Integer userId);
    boolean star(Integer id, Integer userId);
    boolean unstar(Integer id, Integer userId);
    boolean softDelete(Integer id, Integer userId);
    boolean restore(Integer id, Integer userId);
    void autoDeleteExpired(Integer days); // 自动删除超过指定天数的问卷
}
