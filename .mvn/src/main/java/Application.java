package questionnaire;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.web.servlet.ServletComponentScan;

@SpringBootApplication
@MapperScan("questionnaire.dao") //与自己的包结构一样
@ServletComponentScan  // 添加这个注解，扫描 @WebFilter、@WebServlet 等
public class Application {
    public static void main(String[] args) {
        SpringApplication.run(Application.class, args);
    }
}