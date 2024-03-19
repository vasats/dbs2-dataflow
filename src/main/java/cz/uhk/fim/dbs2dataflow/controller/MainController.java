package cz.uhk.fim.dbs2dataflow.controller;


import cz.uhk.fim.dbs2dataflow.model.WebovyUcet;
import cz.uhk.fim.dbs2dataflow.service.SpotrebaService;
import cz.uhk.fim.dbs2dataflow.service.WebovyUcetService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
public class MainController {
    @Autowired
    SpotrebaService spotrebaService;

    @Autowired
    WebovyUcetService webService;

    @GetMapping(value = "/login")
    private String showLoginForm(){


        return "login";
    }

    @GetMapping(value = "/tovarna/{id}")
    private String showFactoryInfo(Model model){


        return "tovarna";
    }

    @GetMapping(value = "/test")
    @ResponseBody
    private String test(){
        List<WebovyUcet> spotrebes = webService.getAll();
        StringBuilder builder = new StringBuilder();
        spotrebes.forEach(e -> builder.append(e.getJmeno() + " " + e.getTypuctu()));
        return builder.toString();
    }
}
