package com.questionnaire.controller;

import com.questionnaire.model.Question;
import com.questionnaire.model.QuestionOption;
import com.questionnaire.model.User;
import com.questionnaire.service.QuestionOptionService;
import com.questionnaire.service.QuestionService;
import com.questionnaire.service.QuestionnaireService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping("/question")
public class QuestionController {

    @Autowired
    private QuestionService questionService;
    
    @Autowired
    private QuestionOptionService optionService;
    
    @Autowired
    private QuestionnaireService questionnaireService;

    @PostMapping("/add")
    public String addQuestion(@AuthenticationPrincipal User user,
                             @RequestParam Integer questionnaireId,
                             @RequestParam String questionText,
                             @RequestParam Integer questionType,
                             @RequestParam(required = false, defaultValue = "1") Integer isRequired,
                             @RequestParam(required = false) String[] options,
                             RedirectAttributes redirectAttributes) {
        
        if (!questionnaireService.isOwner(questionnaireId, user.getId()) && 
            !user.getRole().equals("admin") && 
            !user.getRole().equals("administrator")) {
            redirectAttributes.addFlashAttribute("error", "无权添加问题！");
            return "redirect:/questionnaire/list";
        }
        
        try {
            // 创建问题
            Question question = new Question();
            question.setQuestionnaireId(questionnaireId);
            question.setQuestionText(questionText);
            question.setQuestionType(questionType);
            question.setIsRequired(isRequired);
            question.setQuestionOrder(0);
            
            questionService.create(question);
            
            // 如果是选择题，创建选项
            if (questionType != 3 && options != null && options.length > 0) {
                for (int i = 0; i < options.length; i++) {
                    if (options[i] != null && !options[i].trim().isEmpty()) {
                        QuestionOption option = new QuestionOption();
                        option.setQuestionId(question.getId());
                        option.setOptionText(options[i].trim());
                        option.setOptionOrder(i);
                        optionService.create(option);
                    }
                }
            }
            
            redirectAttributes.addFlashAttribute("message", "问题添加成功！");
        } catch (Exception e) {
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("error", "问题添加失败：" + e.getMessage());
        }
        
        return "redirect:/questionnaire/design/" + questionnaireId;
    }
    
    @GetMapping("/delete/{id}")
    public String deleteQuestion(@AuthenticationPrincipal User user,
                                @PathVariable Integer id,
                                RedirectAttributes redirectAttributes) {
        
        Question question = questionService.findById(id);
        if (question == null) {
            redirectAttributes.addFlashAttribute("error", "问题不存在！");
            return "redirect:/questionnaire/list";
        }
        
        if (!questionnaireService.isOwner(question.getQuestionnaireId(), user.getId()) && 
            !user.getRole().equals("admin") && 
            !user.getRole().equals("administrator")) {
            redirectAttributes.addFlashAttribute("error", "无权删除此问题！");
            return "redirect:/questionnaire/list";
        }
        
        Integer questionnaireId = question.getQuestionnaireId();
        
        if (questionService.deleteById(id)) {
            redirectAttributes.addFlashAttribute("message", "问题删除成功！");
        } else {
            redirectAttributes.addFlashAttribute("error", "问题删除失败！");
        }
        
        return "redirect:/questionnaire/design/" + questionnaireId;
    }
}
