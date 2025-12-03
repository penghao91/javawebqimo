package com.questionnaire.model;

import lombok.Data;
import java.io.Serializable;
import java.util.Date;
import java.util.List;

@Data
public class Answer implements Serializable {
    private Integer id;
    private Integer questionnaireId;
    private Integer userId;
    private Date submitTime;
    private String ipAddress;
    
    // 关联属性
    private Questionnaire questionnaire;
    private User user;
    private List<AnswerDetail> answerDetails;
}
