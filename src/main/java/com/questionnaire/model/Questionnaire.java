package com.questionnaire.model;

import lombok.Data;
import java.io.Serializable;
import java.util.Date;
import java.util.List;

@Data
public class Questionnaire implements Serializable {
    private Integer id;
    private String title;
    private String description;
    private Integer createdBy;
    private Integer status; // 1-草稿，2-已发布
    private Date createTime;
    private Date updateTime;
    private Integer isStarred; // 0-未星标，1-已星标
    private Integer isDeleted; // 0-未删除，1-已删除
    private Date deletedTime; // 删除时间
    private Integer folderId; // 文件夹ID
    
    // 关联属性
    private User creator;
    private List<Question> questions;
    
    // 状态描述
    public String getStatusDesc() {
        if (status == null) return "";
        switch (status) {
            case 1: return "草稿";
            case 2: return "已发布";
            default: return "未知";
        }
    }
}
