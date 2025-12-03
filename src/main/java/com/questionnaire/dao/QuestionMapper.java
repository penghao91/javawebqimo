package com.questionnaire.dao;

import com.questionnaire.model.Question;
import org.apache.ibatis.annotations.*;
import java.util.List;

@Mapper
public interface QuestionMapper {
    
    @Select("SELECT * FROM question WHERE id = #{id}")
    @Results({
        @Result(property = "id", column = "id"),
        @Result(property = "questionnaireId", column = "questionnaire_id"),
        @Result(property = "questionText", column = "question_text"),
        @Result(property = "questionType", column = "question_type"),
        @Result(property = "questionOrder", column = "question_order"),
        @Result(property = "isRequired", column = "is_required"),
        @Result(property = "createTime", column = "create_time"),
        @Result(property = "updateTime", column = "update_time")
    })
    Question findById(Integer id);
    
    @Select("SELECT * FROM question WHERE questionnaire_id = #{questionnaireId} ORDER BY question_order ASC, id ASC")
    @Results({
        @Result(property = "id", column = "id"),
        @Result(property = "questionnaireId", column = "questionnaire_id"),
        @Result(property = "questionText", column = "question_text"),
        @Result(property = "questionType", column = "question_type"),
        @Result(property = "questionOrder", column = "question_order"),
        @Result(property = "isRequired", column = "is_required"),
        @Result(property = "createTime", column = "create_time"),
        @Result(property = "updateTime", column = "update_time"),
        @Result(property = "options", column = "id", javaType = List.class,
                many = @Many(select = "com.questionnaire.dao.QuestionOptionMapper.findByQuestionId"))
    })
    List<Question> findByQuestionnaireId(Integer questionnaireId);
    
    @Insert("INSERT INTO question (questionnaire_id, question_text, question_type, question_order, is_required) VALUES (#{questionnaireId}, #{questionText}, #{questionType}, #{questionOrder}, #{isRequired})")
    @Options(useGeneratedKeys = true, keyProperty = "id")
    int insert(Question question);
    
    @Update("UPDATE question SET question_text = #{questionText}, question_type = #{questionType}, question_order = #{questionOrder}, is_required = #{isRequired} WHERE id = #{id}")
    int update(Question question);
    
    @Delete("DELETE FROM question WHERE id = #{id}")
    int deleteById(Integer id);
    
    @Delete("DELETE FROM question WHERE questionnaire_id = #{questionnaireId}")
    int deleteByQuestionnaireId(Integer questionnaireId);
}
