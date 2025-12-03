package com.questionnaire.model;

import lombok.Data;
import java.io.Serializable;
import java.util.Date;
import java.util.List;

@Data
public class Question implements Serializable {
    private Integer id;
    private Integer questionnaireId;
    private String questionText;
    private Integer questionType; // 1-单选，2-多选，3-简答
    private Integer questionOrder;
    private Integer isRequired; // 1-是，0-否
    private Date createTime;
    private Date updateTime;
    
    // 关联属性
    private List<QuestionOption> options;
    
    // 题型描述
    public String getTypeDesc() {
        if (questionType == null) return "";
        switch (questionType) {
            case 1: return "单选题";
            case 2: return "多选题";
            case 3: return "简答题";
            default: return "未知";
        }
    }
    
    // 是否必填描述
    public String getRequiredDesc() {
        return (isRequired != null && isRequired == 1) ? "必填" : "选填";
    }
}
