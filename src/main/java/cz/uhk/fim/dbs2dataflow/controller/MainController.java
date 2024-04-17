package cz.uhk.fim.dbs2dataflow.controller;


import cz.uhk.fim.dbs2dataflow.exception.DataNotFoundException;
import cz.uhk.fim.dbs2dataflow.model.*;
import cz.uhk.fim.dbs2dataflow.service.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.view.RedirectView;

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
    @Autowired
    ZarizeniService zarizeniService;
    @Autowired
    SmenaService smenaService;

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
        return "smenaDetail";
    }

    @GetMapping(value = "/test")
    private String test(Model model){
        List<WebovyUcet> spotrebes = webService.getAll();
        model.addAttribute("ucty", spotrebes);
        return "test";
    }
    @GetMapping(value = "/hala/{id}/zarizeni")
    private String showZarizeni(@PathVariable("id") int id,Model model){
        Zarizeni newZarizeni = new Zarizeni();
        newZarizeni.setHala(halaService.getByID(id));

        model.addAttribute("newZarizeni", newZarizeni);
        model.addAttribute("hala",halaService.getByID(id));
        model.addAttribute("zarizeni", zarizeniService.getByHalaID(id));

        return "zarizeni";
    }
    @PostMapping(value = "/hala/{id}/zarizeni")
    private RedirectView addZarizeni(@PathVariable("id") int id, @ModelAttribute Zarizeni newZarizeni){
        newZarizeni.setHala(halaService.getByID(id));
        newZarizeni.setId(null);
        zarizeniService.addZarizeni(newZarizeni);
        return new RedirectView("/hala/"+id+"/zarizeni");
    }
    @GetMapping(value = "/hala/{id}/smeny")
    private String showSmeny(@PathVariable("id") int id, Model model){
        model.addAttribute("smeny", smenaService.getAllByHalaID(id));
        model.addAttribute("hala", halaService.getByID(id));


        return "smeny";
    }
    @RequestMapping(value = "/")
    private String fallback(){
        return "redirect:/main";
    }
}
