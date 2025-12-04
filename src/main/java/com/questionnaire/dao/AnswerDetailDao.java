package com.questionnaire.dao;

import com.questionnaire.model.AnswerDetail;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface AnswerDetailDao {
    
    AnswerDetail findById(Integer id);
    
    List<AnswerDetail> findByAnswerId(Integer answerId);
    
    int insert(AnswerDetail answerDetail);
    
    int countByQuestionAndAnswer(@Param("questionId") Integer questionId, @Param("answerText") String answerText);
}