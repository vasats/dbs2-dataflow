package cz.uhk.fim.dbs2dataflow;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;

@SpringBootApplication
public class Dbs2DataflowApplication extends SpringBootServletInitializer {
    @Override
    protected SpringApplicationBuilder configure(SpringApplicationBuilder builder){
        return builder.sources(Dbs2DataflowApplication.class);
    }

    public static void main(String[] args) {
        SpringApplication.run(Dbs2DataflowApplication.class, args);
    }

}
