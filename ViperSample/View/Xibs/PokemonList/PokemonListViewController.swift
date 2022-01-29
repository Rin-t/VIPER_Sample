//
//  ViewController.swift
//  ViperSample
//
//  Created by Rin on 2022/01/27.
//

import UIKit

final class PokemonListViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            tableView.register(HomeTableViewCell.nib(), forCellReuseIdentifier: HomeTableViewCell.identifire)
            tableView.delegate = self
            tableView.dataSource = self
        }
    }

    private var presenter: PokemonListPresenterProtocol!
    private var pokemonEntities = [PokemonEntity]()

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = PokemonListPresenter(view: self,
                                         inject: PokemonListPresenter.Dependency(
                                            router: PokemonListRouter(view: self),
                                            getPokemonArrayUseCase: UseCase(GetPokemonArrayUseCase()))
        )
        presenter.didLoad()
    }
}

extension PokemonListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemonEntities.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCell.identifire, for: indexPath) as! HomeTableViewCell
        cell.configure(pokemonEntities[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        print(indexPath.row)
        presenter.didSelect(pokemonEntity: pokemonEntities[indexPath.row])
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        50
    }
}

extension PokemonListViewController: PokemonListViewProtocol {
    func showPokemon(_ pokemonEntities: [PokemonEntity]) {
        self.pokemonEntities = pokemonEntities
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

    func showEmpty() {
        showPokemon([])
    }

    func showError(_ error: Error) {
        printContent(error)
    }
}

