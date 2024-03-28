package cz.uhk.fim.dbs2dataflow.service;

import cz.uhk.fim.dbs2dataflow.model.Hala;
import cz.uhk.fim.dbs2dataflow.model.SeznamZamestnancuSmeny;
import cz.uhk.fim.dbs2dataflow.model.Smena;
import cz.uhk.fim.dbs2dataflow.repository.SeznamZamestnancuRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class SeznamZamestnancuService {
    @Autowired
    SeznamZamestnancuRepository repository;

    public List<SeznamZamestnancuSmeny> getAllbyHalaIDSmenaID(int halaID, int smenaID){

        return repository.getAllBySeznamZamestnancuID_Hala_HalaIDAndSeznamZamestnancuID_SmenaId(halaID,smenaID);
    }
}
