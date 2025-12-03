package com.questionnaire.controller;

import com.questionnaire.model.*;
import com.questionnaire.service.AnswerService;
import com.questionnaire.service.QuestionService;
import com.questionnaire.service.QuestionnaireService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

@Controller
@RequestMapping("/answer")
public class AnswerController {

    @Autowired
    private QuestionnaireService questionnaireService;
    
    @Autowired
    private QuestionService questionService;
    
    @Autowired
    private AnswerService answerService;

    @GetMapping("/fill/{questionnaireId}")
    public String fillForm(@PathVariable Integer questionnaireId,
                          Model model,
                          RedirectAttributes redirectAttributes) {
        
        Questionnaire questionnaire = questionnaireService.findById(questionnaireId);
        
        if (questionnaire == null) {
            redirectAttributes.addFlashAttribute("error", "问卷不存在！");
            return "redirect:/questionnaire/list";
        }
        
        if (questionnaire.getStatus() != 2) {
            redirectAttributes.addFlashAttribute("error", "问卷未发布！");
            return "redirect:/questionnaire/list";
        }
        
        List<Question> questions = questionService.findByQuestionnaireId(questionnaireId);
        
        model.addAttribute("questionnaire", questionnaire);
        model.addAttribute("questions", questions);
        
        return "answer/fill";
    }
    
    @PostMapping("/submit/{questionnaireId}")
    public String submitAnswer(@PathVariable Integer questionnaireId,
                              @AuthenticationPrincipal User user,
                              HttpServletRequest request,
                              RedirectAttributes redirectAttributes) {
        
        Questionnaire questionnaire = questionnaireService.findById(questionnaireId);
        
        if (questionnaire == null) {
            redirectAttributes.addFlashAttribute("error", "问卷不存在！");
            return "redirect:/questionnaire/list";
        }
        
        if (questionnaire.getStatus() != 2) {
            redirectAttributes.addFlashAttribute("error", "问卷未发布！");
            return "redirect:/questionnaire/list";
        }
        
        if (answerService.submitAnswer(questionnaireId, request)) {
            redirectAttributes.addFlashAttribute("message", "问卷提交成功！感谢您的参与！");
        } else {
            redirectAttributes.addFlashAttribute("error", "问卷提交失败，请重试！");
        }
        
        return "redirect:/questionnaire/list";
    }
}
