package cz.uhk.fim.dbs2dataflow.controller;


import cz.uhk.fim.dbs2dataflow.exception.DataNotFoundException;
import cz.uhk.fim.dbs2dataflow.model.WebovyUcet;
import cz.uhk.fim.dbs2dataflow.service.SpotrebaService;
import cz.uhk.fim.dbs2dataflow.service.TovarnaService;
import cz.uhk.fim.dbs2dataflow.service.WebovyUcetService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;

@Controller
public class MainController {
    @Autowired
    SpotrebaService spotrebaService;

    @Autowired
    WebovyUcetService webService;

    @Autowired
    TovarnaService tovarnaService;
    @GetMapping(value = "/main")
    public String showMainPage(){


        return "index";
    }

    @GetMapping(value = "/tovarna/{id}")
    private String showFactoryInfo(@PathVariable("id") Integer id, Model model){
        try {
            model.addAttribute(tovarnaService.getTovarnaById(id));
        } catch (DataNotFoundException e){

        }

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
    @RequestMapping(value = "/")
    private String fallback(){
        //todo remove this
        return "redirect:/test";
    }
}
