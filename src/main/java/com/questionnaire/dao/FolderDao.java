package com.questionnaire.dao;

import com.questionnaire.model.Folder;
import org.apache.ibatis.annotations.*;
import java.util.List;

@Mapper
public interface FolderDao {
    
    @Select("SELECT * FROM folder WHERE user_id = #{userId} ORDER BY create_time DESC")
    @Results({
        @Result(property = "id", column = "id"),
        @Result(property = "name", column = "name"),
        @Result(property = "userId", column = "user_id"),
        @Result(property = "parentId", column = "parent_id"),
        @Result(property = "createTime", column = "create_time"),
        @Result(property = "updateTime", column = "update_time")
    })
    List<Folder> findByUserId(Integer userId);
    
    @Select("SELECT * FROM folder WHERE id = #{id}")
    @Results({
        @Result(property = "id", column = "id"),
        @Result(property = "name", column = "name"),
        @Result(property = "userId", column = "user_id"),
        @Result(property = "parentId", column = "parent_id"),
        @Result(property = "createTime", column = "create_time"),
        @Result(property = "updateTime", column = "update_time")
    })
    Folder findById(Integer id);
    
    @Insert("INSERT INTO folder(name, user_id, parent_id, create_time, update_time) VALUES(#{name}, #{userId}, #{parentId}, NOW(), NOW())")
    @Options(useGeneratedKeys = true, keyProperty = "id")
    int insert(Folder folder);
    
    @Update("UPDATE folder SET name = #{name}, parent_id = #{parentId}, update_time = NOW() WHERE id = #{id}")
    int update(Folder folder);
    
    @Delete("DELETE FROM folder WHERE id = #{id}")
    int delete(Integer id);
}