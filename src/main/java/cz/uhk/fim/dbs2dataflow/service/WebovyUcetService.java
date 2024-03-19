package cz.uhk.fim.dbs2dataflow.service;

import cz.uhk.fim.dbs2dataflow.model.WebovyUcet;
import cz.uhk.fim.dbs2dataflow.repository.WebovyUcetRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class WebovyUcetService {
    @Autowired
    WebovyUcetRepository webovyUcetRepository;

    public WebovyUcet getByName(String name){
        return webovyUcetRepository.findWebovyUcetByJmeno(name);
    }
    public List<WebovyUcet> getAll(){
        return (List<WebovyUcet>) webovyUcetRepository.findAll();
    }
}
