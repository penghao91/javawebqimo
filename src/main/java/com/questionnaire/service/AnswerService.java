package com.questionnaire.service;

import com.questionnaire.model.Answer;
import javax.servlet.http.HttpServletRequest;
import java.util.List;

public interface AnswerService {
    Answer findById(Integer id);
    List<Answer> findByQuestionnaireId(Integer questionnaireId);
    int countByQuestionnaireId(Integer questionnaireId);
    boolean submitAnswer(Integer questionnaireId, HttpServletRequest request);
}
