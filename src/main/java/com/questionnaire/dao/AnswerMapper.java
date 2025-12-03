package com.questionnaire.dao;

import com.questionnaire.model.Answer;
import org.apache.ibatis.annotations.*;
import java.util.List;

@Mapper
public interface AnswerMapper {
    
    @Select("SELECT * FROM answer WHERE id = #{id}")
    @Results({
        @Result(property = "id", column = "id"),
        @Result(property = "questionnaireId", column = "questionnaire_id"),
        @Result(property = "userId", column = "user_id"),
        @Result(property = "submitTime", column = "submit_time"),
        @Result(property = "ipAddress", column = "ip_address")
    })
    Answer findById(Integer id);
    
    @Select("SELECT * FROM answer WHERE questionnaire_id = #{questionnaireId} ORDER BY submit_time DESC")
    @Results({
        @Result(property = "id", column = "id"),
        @Result(property = "questionnaireId", column = "questionnaire_id"),
        @Result(property = "userId", column = "user_id"),
        @Result(property = "submitTime", column = "submit_time"),
        @Result(property = "ipAddress", column = "ip_address"),
        @Result(property = "user", column = "user_id", javaType = com.questionnaire.model.User.class,
                one = @One(select = "com.questionnaire.dao.UserMapper.findById"))
    })
    List<Answer> findByQuestionnaireId(Integer questionnaireId);
    
    @Select("SELECT COUNT(*) FROM answer WHERE questionnaire_id = #{questionnaireId}")
    int countByQuestionnaireId(Integer questionnaireId);
    
    @Insert("INSERT INTO answer (questionnaire_id, user_id, ip_address) VALUES (#{questionnaireId}, #{userId}, #{ipAddress})")
    @Options(useGeneratedKeys = true, keyProperty = "id")
    int insert(Answer answer);
}
