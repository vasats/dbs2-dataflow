package cz.uhk.fim.dbs2dataflow.repository;

import cz.uhk.fim.dbs2dataflow.model.WebovyUcet;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;
import org.springframework.web.bind.annotation.ResponseBody;

@Repository
public interface WebovyUcetRepository extends CrudRepository<WebovyUcet,Integer> {

    WebovyUcet findWebovyUcetByJmeno(String jmeno);
}
