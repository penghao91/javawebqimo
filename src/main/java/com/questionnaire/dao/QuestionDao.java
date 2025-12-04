package com.questionnaire.dao;

import com.questionnaire.model.Question;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface QuestionDao {
    
    Question findById(Integer id);
    
    List<Question> findByQuestionnaireId(Integer questionnaireId);
    
    int insert(Question question);
    
    int update(Question question);
    
    int deleteById(Integer id);
    
    int deleteByQuestionnaireId(Integer questionnaireId);
}