ExUnit.start

Mix.Task.run "ecto.create", ~w(-r Budgetparty.Repo --quiet)
Mix.Task.run "ecto.migrate", ~w(-r Budgetparty.Repo --quiet)
Ecto.Adapters.SQL.begin_test_transaction(Budgetparty.Repo)

