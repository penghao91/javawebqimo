package com.questionnaire.model;

import lombok.Data;
import java.io.Serializable;

@Data
public class AnswerDetail implements Serializable {
    private Integer id;
    private Integer answerId;
    private Integer questionId;
    private String answerText;
    
    // 关联属性
    private Question question;
}
