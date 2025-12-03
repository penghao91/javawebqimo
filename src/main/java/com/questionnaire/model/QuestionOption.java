package com.questionnaire.model;

import lombok.Data;
import java.io.Serializable;

@Data
public class QuestionOption implements Serializable {
    private Integer id;
    private Integer questionId;
    private String optionText;
    private Integer optionOrder;
}
