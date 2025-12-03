package com.questionnaire.dao;

import com.questionnaire.model.Questionnaire;
import org.apache.ibatis.annotations.*;
import java.util.List;

@Mapper
public interface QuestionnaireMapper {
    
    @Select("SELECT * FROM questionnaire WHERE id = #{id}")
    @Results({
        @Result(property = "id", column = "id"),
        @Result(property = "title", column = "title"),
        @Result(property = "description", column = "description"),
        @Result(property = "createdBy", column = "created_by"),
        @Result(property = "status", column = "status"),
        @Result(property = "createTime", column = "create_time"),
        @Result(property = "updateTime", column = "update_time"),
        @Result(property = "creator", column = "created_by", javaType = com.questionnaire.model.User.class,
                one = @One(select = "com.questionnaire.dao.UserMapper.findById"))
    })
    Questionnaire findById(Integer id);
    
    @Select("SELECT * FROM questionnaire WHERE created_by = #{userId} ORDER BY update_time DESC")
    @Results({
        @Result(property = "id", column = "id"),
        @Result(property = "title", column = "title"),
        @Result(property = "description", column = "description"),
        @Result(property = "createdBy", column = "created_by"),
        @Result(property = "status", column = "status"),
        @Result(property = "createTime", column = "create_time"),
        @Result(property = "updateTime", column = "update_time")
    })
    List<Questionnaire> findByUserId(Integer userId);
    
    @Select("SELECT * FROM questionnaire ORDER BY update_time DESC")
    @Results({
        @Result(property = "id", column = "id"),
        @Result(property = "title", column = "title"),
        @Result(property = "description", column = "description"),
        @Result(property = "createdBy", column = "created_by"),
        @Result(property = "status", column = "status"),
        @Result(property = "createTime", column = "create_time"),
        @Result(property = "updateTime", column = "update_time"),
        @Result(property = "creator", column = "created_by", javaType = com.questionnaire.model.User.class,
                one = @One(select = "com.questionnaire.dao.UserMapper.findById"))
    })
    List<Questionnaire> findAll();
    
    @Insert("INSERT INTO questionnaire (title, description, created_by, status) VALUES (#{title}, #{description}, #{createdBy}, #{status})")
    @Options(useGeneratedKeys = true, keyProperty = "id")
    int insert(Questionnaire questionnaire);
    
    @Update("UPDATE questionnaire SET title = #{title}, description = #{description}, status = #{status} WHERE id = #{id}")
    int update(Questionnaire questionnaire);
    
    @Delete("DELETE FROM questionnaire WHERE id = #{id}")
    int deleteById(Integer id);
    
    @Update("UPDATE questionnaire SET status = #{status} WHERE id = #{id}")
    int updateStatus(@Param("id") Integer id, @Param("status") Integer status);
}
