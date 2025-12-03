package com.questionnaire.dao;

import com.questionnaire.model.AnswerDetail;
import org.apache.ibatis.annotations.*;
import java.util.List;

@Mapper
public interface AnswerDetailMapper {
    
    @Select("SELECT * FROM answer_detail WHERE id = #{id}")
    @Results({
        @Result(property = "id", column = "id"),
        @Result(property = "answerId", column = "answer_id"),
        @Result(property = "questionId", column = "question_id"),
        @Result(property = "answerText", column = "answer_text")
    })
    AnswerDetail findById(Integer id);
    
    @Select("SELECT * FROM answer_detail WHERE answer_id = #{answerId}")
    @Results({
        @Result(property = "id", column = "id"),
        @Result(property = "answerId", column = "answer_id"),
        @Result(property = "questionId", column = "question_id"),
        @Result(property = "answerText", column = "answer_text"),
        @Result(property = "question", column = "question_id", javaType = com.questionnaire.model.Question.class,
                one = @One(select = "com.questionnaire.dao.QuestionMapper.findById"))
    })
    List<AnswerDetail> findByAnswerId(Integer answerId);
    
    @Insert("INSERT INTO answer_detail (answer_id, question_id, answer_text) VALUES (#{answerId}, #{questionId}, #{answerText})")
    @Options(useGeneratedKeys = true, keyProperty = "id")
    int insert(AnswerDetail answerDetail);
    
    @Select("SELECT COUNT(*) FROM answer_detail WHERE question_id = #{questionId} AND answer_text = #{answerText}")
    int countByQuestionAndAnswer(@Param("questionId") Integer questionId, @Param("answerText") String answerText);
}
