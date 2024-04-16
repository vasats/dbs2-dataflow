package cz.uhk.fim.dbs2dataflow.controller;


import cz.uhk.fim.dbs2dataflow.exception.DataNotFoundException;
import cz.uhk.fim.dbs2dataflow.model.*;
import cz.uhk.fim.dbs2dataflow.service.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
public class MainController {
    @Autowired
    SpotrebaService spotrebaService;

    @Autowired
    WebovyUcetService webService;

    @Autowired
    TovarnaService tovarnaService;
    @Autowired
    SeznamZamestnancuService seznamZamestnancuService;

    @Autowired
    HalaService halaService;

    @Autowired
    SpotrebaInfoViewService spotrebaInfoViewService;

    @GetMapping(value = "/main")
    public String showMainPage(Model model){
        List<Tovarna> tovarny = tovarnaService.getAll();
        List<TovarnaInfo> tovarnyInfo = tovarny.stream()
                .map((tovarna ->
                        new TovarnaInfo(tovarna,
                                halaService.getAmountByTovarna(tovarna))))
                .toList();
        model.addAttribute("tovarny",tovarnyInfo);

        return "index";
    }

    @GetMapping(value = "/tovarna/{id}")
    private String showFactoryInfo(@PathVariable("id") Integer id, Model model){
        model.addAttribute("newHala", new Hala());
        try {
            model.addAttribute("haly",halaService.getByTovarnaId(id));
            model.addAttribute("tovarna", tovarnaService.getTovarnaById(id));
            model.addAttribute("spotreba", tovarnaService.getSpotrebabyId(id) + " ");
        } catch (DataNotFoundException e){

        }
        return "tovarna";
    }
    @PostMapping(value = "/tovarna/{id}")
    private RedirectView addNewHala(@ModelAttribute Hala newHala, @PathVariable Integer id){
        Tovarna tovarna = tovarnaService.getTovarnaById(id);
        halaService.addHala(newHala, tovarna);
        return new RedirectView("/tovarna/"+id);
    }

    @GetMapping(value = "/hala/{id}")
    private String showHalaInfo(@PathVariable("id") Integer id, Model model){
        try {
            model.addAttribute("zarizeni",spotrebaInfoViewService.getByHalaId(id));
        } catch (DataNotFoundException e){

        }
        return "hala";
    }
    @GetMapping(value = "/smena/{smenaID}/{halaID}")
    private String smenaDetail(@PathVariable("smenaID") int smenaID,
                               @PathVariable("halaID") int halaID, Model model){

        List<SeznamZamestnancuSmeny> seznam = seznamZamestnancuService.getAllbyHalaIDSmenaID(halaID, smenaID);
        model.addAttribute("seznamZamestnancuSmeny", seznam);
        return "smena";
    }

    @GetMapping(value = "/test")
    private String test(Model model){
        List<WebovyUcet> spotrebes = webService.getAll();
        model.addAttribute("ucty", spotrebes);
        return "test";
    }
    @RequestMapping(value = "/")
    private String fallback(){
        return "redirect:/main";
    }
}
