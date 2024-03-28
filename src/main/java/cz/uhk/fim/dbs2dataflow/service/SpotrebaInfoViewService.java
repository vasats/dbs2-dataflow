package cz.uhk.fim.dbs2dataflow.service;

import cz.uhk.fim.dbs2dataflow.repository.SpotrebaInfoViewRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class SpotrebaInfoViewService {

    @Autowired
    SpotrebaInfoViewRepository repository;


}
