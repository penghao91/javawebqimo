package com.questionnaire.service;

import com.questionnaire.model.Question;
import java.util.List;

public interface QuestionService {
    Question findById(Integer id);
    List<Question> findByQuestionnaireId(Integer questionnaireId);
    boolean create(Question question);
    boolean update(Question question);
    boolean deleteById(Integer id);
    boolean deleteByQuestionnaireId(Integer questionnaireId);
}
