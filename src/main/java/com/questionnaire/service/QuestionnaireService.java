package com.questionnaire.service;

import com.questionnaire.model.Questionnaire;
import java.util.List;

public interface QuestionnaireService {
    Questionnaire findById(Integer id);
    List<Questionnaire> findByUserId(Integer userId);
    List<Questionnaire> findAll();
    boolean create(Questionnaire questionnaire);
    boolean update(Questionnaire questionnaire);
    boolean deleteById(Integer id, Integer userId);
    boolean publish(Integer id, Integer userId);
    boolean isOwner(Integer questionnaireId, Integer userId);
}
