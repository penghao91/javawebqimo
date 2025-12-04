package com.questionnaire.dao;

import com.questionnaire.model.Answer;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface AnswerDao {
    
    Answer findById(Integer id);
    
    List<Answer> findByQuestionnaireId(Integer questionnaireId);
    
    int countByQuestionnaireId(Integer questionnaireId);
    
    int insert(Answer answer);
}