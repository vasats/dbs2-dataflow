package cz.uhk.fim.dbs2dataflow.controller;


import cz.uhk.fim.dbs2dataflow.exception.DataNotFoundException;
import cz.uhk.fim.dbs2dataflow.model.*;
import cz.uhk.fim.dbs2dataflow.service.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.view.RedirectView;

import java.util.HashSet;
import java.util.List;
import java.util.Set;

@Controller
public class MainController {
    SpotrebaService spotrebaService;
    WebovyUcetService webService;
    TovarnaService tovarnaService;
    SeznamZamestnancuService seznamZamestnancuService;
    HalaService halaService;
    SpotrebaInfoViewService spotrebaInfoViewService;
    ZarizeniService zarizeniService;
    SmenaService smenaService;
    ZamestnanecService zamestnanecService;
    AdresaService adresaService;
    MestoService mestoService;
    @Autowired
    public MainController(SpotrebaService spotrebaService,
                          WebovyUcetService webService,
                          TovarnaService tovarnaService,
                          SeznamZamestnancuService seznamZamestnancuService,
                          HalaService halaService,
                          SpotrebaInfoViewService spotrebaInfoViewService,
                          ZarizeniService zarizeniService,
                          SmenaService smenaService,
                          ZamestnanecService zamestnanecService,
                          AdresaService adresaService,
                          MestoService mestoService) {
        this.spotrebaService = spotrebaService;
        this.webService = webService;
        this.tovarnaService = tovarnaService;
        this.seznamZamestnancuService = seznamZamestnancuService;
        this.halaService = halaService;
        this.spotrebaInfoViewService = spotrebaInfoViewService;
        this.zarizeniService = zarizeniService;
        this.smenaService = smenaService;
        this.zamestnanecService = zamestnanecService;
        this.adresaService = adresaService;
        this.mestoService = mestoService;
    }

    @GetMapping(value = "/main")
    public String showMainPage(Model model){
        List<Tovarna> tovarny = tovarnaService.getAll();
        List<TovarnaInfo> tovarnyInfo = tovarny.stream()
                .map((tovarna ->
                        new TovarnaInfo(tovarna,
                                halaService.getAmountByTovarna(tovarna),
                                mestoService.getByPsc(tovarna.getAdresa().getPsc()).getMesto())))
                .toList();
        model.addAttribute("tovarny",tovarnyInfo);

        return "index";
    }

    @GetMapping(value = "/tovarna/{id}")
    private String showFactoryInfo(@PathVariable("id") Integer id, Model model){
        model.addAttribute("newHala", new Hala());
        try {
            model.addAttribute("haly",halaService.getByTovarnaId(id).stream()
                    .map((e)-> new HalaInfo(zarizeniService.getByHalaID(e.getHalaID()).size(),e)).toList());
            model.addAttribute("tovarna", tovarnaService.getTovarnaById(id));
            model.addAttribute("spotreba", tovarnaService.getSpotrebabyId(id) + " ");
        } catch (DataNotFoundException e){

        }
        return "tovarna";
    }
    @PostMapping(value = "/tovarna/{id}")
    private RedirectView addNewHala(@ModelAttribute Hala newHala, @PathVariable Integer id){
        Tovarna tovarna = tovarnaService.getTovarnaById(id);
        try {
            halaService.addHala(newHala, tovarna);
        } catch (IllegalArgumentException e){}
        return new RedirectView("/tovarna/"+id);
    }

    @GetMapping(value = "/hala/{id}")
    private String showHalaInfo(@PathVariable("id") Integer id, Model model){
        try {
            model.addAttribute("hala", halaService.getByID(id));
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
        try {
            zarizeniService.addZarizeni(newZarizeni);
        } catch (IllegalArgumentException e){

        }
        return new RedirectView("/hala/"+id+"/zarizeni");
    }
    @GetMapping(value = "/hala/{id}/smeny")
    private String showSmeny(@PathVariable("id") int id, Model model){
        List<SeznamZamestnancuSmeny> hala = seznamZamestnancuService.getAllbyHalaID(id);
        Set<Integer> smenyID = new HashSet<>();
        hala.stream().map((e) -> e.getSeznamZamestnancuID().getSmena().getId()).forEach(smenyID::add);

        model.addAttribute("smeny", smenaService.getAll(smenyID));
        model.addAttribute("hala", halaService.getByID(id));

        return "smeny";
    }
    @GetMapping(value = "/zamestnanci")
    private String showZamestnanci(Model model){

        model.addAttribute("zamestnanci", zamestnanecService.getAll());
        model.addAttribute("newZamestnanec", new Zamestnanec());
        model.addAttribute("newAdresa", new Adresa());

        return "zamestnanci";
    }
    @PostMapping(value = "/zamestnanci")
    private String newZamestnanci(@ModelAttribute(value = "newZamestnanec") Zamestnanec zamestnanec,
                                  @ModelAttribute(value = "newAdresa") Adresa adresa){
        zamestnanec.setAdresa(adresa);
        try {
            zamestnanecService.insertZamestnanecAdresa(adresa, zamestnanec);
        } catch (IllegalArgumentException e){
            System.out.println(e.getMessage());
        }

        return "redirect:/zamestnanci";
    }
    @RequestMapping(value = "/")
    private String fallback(){
        return "redirect:/main";
    }
}
