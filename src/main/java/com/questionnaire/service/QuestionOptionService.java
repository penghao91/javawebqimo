package com.questionnaire.service;

import com.questionnaire.model.QuestionOption;
import java.util.List;

public interface QuestionOptionService {
    QuestionOption findById(Integer id);
    List<QuestionOption> findByQuestionId(Integer questionId);
    boolean create(QuestionOption option);
    boolean update(QuestionOption option);
    boolean deleteById(Integer id);
    boolean deleteByQuestionId(Integer questionId);
}
