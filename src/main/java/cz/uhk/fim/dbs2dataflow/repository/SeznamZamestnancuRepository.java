package cz.uhk.fim.dbs2dataflow.repository;

import cz.uhk.fim.dbs2dataflow.model.Hala;
import cz.uhk.fim.dbs2dataflow.model.SeznamZamestnancuID;
import cz.uhk.fim.dbs2dataflow.model.SeznamZamestnancuSmeny;
import cz.uhk.fim.dbs2dataflow.model.Smena;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
@Repository
public interface SeznamZamestnancuRepository extends CrudRepository<SeznamZamestnancuSmeny, SeznamZamestnancuID> {
    @Query
    List<SeznamZamestnancuSmeny> getAllBySeznamZamestnancuID_Hala_HalaIDAndSeznamZamestnancuID_SmenaId(int halaID, int smenaID);

    @Query
    List<SeznamZamestnancuSmeny> getAllBySeznamZamestnancuID_Hala_HalaID(int id);
}
