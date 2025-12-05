package com.questionnaire.model;

import lombok.Data;
import java.io.Serializable;
import java.util.Date;

@Data
public class Folder implements Serializable {
    private Integer id;
    private String name;
    private Integer userId;
    private Integer parentId;
    private Date createTime;
    private Date updateTime;
    
    // 关联属性
    private User user;
    private Folder parent;
}