package com.questionnaire.dao;

import com.questionnaire.model.QuestionOption;
import org.apache.ibatis.annotations.*;
import java.util.List;

@Mapper
public interface QuestionOptionMapper {
    
    @Select("SELECT * FROM question_option WHERE id = #{id}")
    @Results({
        @Result(property = "id", column = "id"),
        @Result(property = "questionId", column = "question_id"),
        @Result(property = "optionText", column = "option_text"),
        @Result(property = "optionOrder", column = "option_order")
    })
    QuestionOption findById(Integer id);
    
    @Select("SELECT * FROM question_option WHERE question_id = #{questionId} ORDER BY option_order ASC, id ASC")
    @Results({
        @Result(property = "id", column = "id"),
        @Result(property = "questionId", column = "question_id"),
        @Result(property = "optionText", column = "option_text"),
        @Result(property = "optionOrder", column = "option_order")
    })
    List<QuestionOption> findByQuestionId(Integer questionId);
    
    @Insert("INSERT INTO question_option (question_id, option_text, option_order) VALUES (#{questionId}, #{optionText}, #{optionOrder})")
    @Options(useGeneratedKeys = true, keyProperty = "id")
    int insert(QuestionOption option);
    
    @Update("UPDATE question_option SET option_text = #{optionText}, option_order = #{optionOrder} WHERE id = #{id}")
    int update(QuestionOption option);
    
    @Delete("DELETE FROM question_option WHERE id = #{id}")
    int deleteById(Integer id);
    
    @Delete("DELETE FROM question_option WHERE question_id = #{questionId}")
    int deleteByQuestionId(Integer questionId);
}
