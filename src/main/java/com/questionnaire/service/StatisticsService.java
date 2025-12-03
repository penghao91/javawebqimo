package com.questionnaire.service;

import com.questionnaire.model.Questionnaire;
import java.util.List;
import java.util.Map;

public interface StatisticsService {
    /**
     * 获取问卷统计信息
     * @param questionnaireId 问卷ID
     * @return 包含统计数据的Map
     */
    Map<String, Object> getQuestionnaireStatistics(Integer questionnaireId);
    
    /**
     * 获取问题统计信息
     * @param questionId 问题ID
     * @return 选项统计列表
     */
    List<Map<String, Object>> getQuestionStatistics(Integer questionId);
}
