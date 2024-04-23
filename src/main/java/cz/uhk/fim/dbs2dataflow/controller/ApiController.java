package cz.uhk.fim.dbs2dataflow.controller;

import cz.uhk.fim.dbs2dataflow.model.ZaznamOPouziti;
import cz.uhk.fim.dbs2dataflow.model.ZaznamOSpotrebe;
import cz.uhk.fim.dbs2dataflow.service.SpotrebaService;
import cz.uhk.fim.dbs2dataflow.service.ZaznamOPouzitiService;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;

import java.util.List;

@Controller
public class ApiController {

    @Autowired
    SpotrebaService spotrebaService;

    @Autowired
    ZaznamOPouzitiService zaznamOPouzitiService;

    @PostMapping(path = "/api/pouziti")
    public void registerUses(@Valid @RequestBody List<ZaznamOPouziti> uses){
        zaznamOPouzitiService.saveAll(uses);
    }

    @PostMapping(path = "/api/spotreba")
    public void registerSpotreba(@Valid @RequestBody List<ZaznamOSpotrebe> spotreby){
        spotrebaService.saveAll(spotreby);
    }
}
