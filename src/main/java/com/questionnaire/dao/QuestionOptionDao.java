package com.questionnaire.dao;

import com.questionnaire.model.QuestionOption;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface QuestionOptionDao {
    
    QuestionOption findById(Integer id);
    
    List<QuestionOption> findByQuestionId(Integer questionId);
    
    int insert(QuestionOption option);
    
    int update(QuestionOption option);
    
    int deleteById(Integer id);
    
    int deleteByQuestionId(Integer questionId);
}