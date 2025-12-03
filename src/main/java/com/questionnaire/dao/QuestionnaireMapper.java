package com.questionnaire.dao;

import com.questionnaire.model.Questionnaire;
import org.apache.ibatis.annotations.*;
import java.util.List;
import java.util.Date;

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
    
    @Insert("INSERT INTO questionnaire (title, description, created_by, status, is_starred, is_deleted, folder_id) VALUES (#{title}, #{description}, #{createdBy}, #{status}, #{isStarred}, #{isDeleted}, #{folderId})")
    @Options(useGeneratedKeys = true, keyProperty = "id")
    int insert(Questionnaire questionnaire);
    
    @Update("UPDATE questionnaire SET title = #{title}, description = #{description}, status = #{status}, is_starred = #{isStarred}, is_deleted = #{isDeleted}, folder_id = #{folderId} WHERE id = #{id}")
    int update(Questionnaire questionnaire);
    
    @Delete("DELETE FROM questionnaire WHERE id = #{id}")
    int deleteById(Integer id);
    
    @Update("UPDATE questionnaire SET status = #{status} WHERE id = #{id}")
    int updateStatus(@Param("id") Integer id, @Param("status") Integer status);
    
    @Update("UPDATE questionnaire SET is_starred = #{isStarred} WHERE id = #{id}")
    int updateStarred(@Param("id") Integer id, @Param("isStarred") Integer isStarred);
    
    @Update("UPDATE questionnaire SET is_deleted = #{isDeleted}, deleted_time = #{deletedTime} WHERE id = #{id}")
    int updateDeleted(@Param("id") Integer id, @Param("isDeleted") Integer isDeleted, @Param("deletedTime") Date deletedTime);
    
    @Select("SELECT * FROM questionnaire WHERE is_deleted = 1 AND deleted_time <= #{expireTime}")
    @Results({
        @Result(property = "id", column = "id"),
        @Result(property = "title", column = "title"),
        @Result(property = "description", column = "description"),
        @Result(property = "createdBy", column = "created_by"),
        @Result(property = "status", column = "status"),
        @Result(property = "createTime", column = "create_time"),
        @Result(property = "updateTime", column = "update_time"),
        @Result(property = "isStarred", column = "is_starred"),
        @Result(property = "isDeleted", column = "is_deleted"),
        @Result(property = "deletedTime", column = "deleted_time"),
        @Result(property = "folderId", column = "folder_id")
    })
    List<Questionnaire> findExpiredDeleted(Date expireTime);
    
    @Update("UPDATE questionnaire SET folder_id = #{folderId} WHERE id = #{id}")
    int updateFolder(@Param("id") Integer id, @Param("folderId") Integer folderId);
    
    @Select("SELECT * FROM questionnaire WHERE created_by = #{userId} AND is_deleted = 0 ORDER BY update_time DESC")
    @Results({
        @Result(property = "id", column = "id"),
        @Result(property = "title", column = "title"),
        @Result(property = "description", column = "description"),
        @Result(property = "createdBy", column = "created_by"),
        @Result(property = "status", column = "status"),
        @Result(property = "createTime", column = "create_time"),
        @Result(property = "updateTime", column = "update_time"),
        @Result(property = "isStarred", column = "is_starred"),
        @Result(property = "isDeleted", column = "is_deleted"),
        @Result(property = "folderId", column = "folder_id")
    })
    List<Questionnaire> findActiveByUserId(Integer userId);
    
    @Select("SELECT * FROM questionnaire WHERE created_by = #{userId} AND is_starred = 1 AND is_deleted = 0 ORDER BY update_time DESC")
    @Results({
        @Result(property = "id", column = "id"),
        @Result(property = "title", column = "title"),
        @Result(property = "description", column = "description"),
        @Result(property = "createdBy", column = "created_by"),
        @Result(property = "status", column = "status"),
        @Result(property = "createTime", column = "create_time"),
        @Result(property = "updateTime", column = "update_time"),
        @Result(property = "isStarred", column = "is_starred"),
        @Result(property = "isDeleted", column = "is_deleted"),
        @Result(property = "folderId", column = "folder_id")
    })
    List<Questionnaire> findStarredByUserId(Integer userId);
    
    @Select("SELECT * FROM questionnaire WHERE created_by = #{userId} AND is_deleted = 1 ORDER BY update_time DESC")
    @Results({
        @Result(property = "id", column = "id"),
        @Result(property = "title", column = "title"),
        @Result(property = "description", column = "description"),
        @Result(property = "createdBy", column = "created_by"),
        @Result(property = "status", column = "status"),
        @Result(property = "createTime", column = "create_time"),
        @Result(property = "updateTime", column = "update_time"),
        @Result(property = "isStarred", column = "is_starred"),
        @Result(property = "isDeleted", column = "is_deleted"),
        @Result(property = "folderId", column = "folder_id")
    })
    List<Questionnaire> findDeletedByUserId(Integer userId);
    
    @Select("SELECT * FROM questionnaire WHERE folder_id = #{folderId} AND is_deleted = 0 ORDER BY update_time DESC")
    @Results({
        @Result(property = "id", column = "id"),
        @Result(property = "title", column = "title"),
        @Result(property = "description", column = "description"),
        @Result(property = "createdBy", column = "created_by"),
        @Result(property = "status", column = "status"),
        @Result(property = "createTime", column = "create_time"),
        @Result(property = "updateTime", column = "update_time"),
        @Result(property = "isStarred", column = "is_starred"),
        @Result(property = "isDeleted", column = "is_deleted"),
        @Result(property = "folderId", column = "folder_id")
    })
    List<Questionnaire> findByFolderId(Integer folderId);
}
