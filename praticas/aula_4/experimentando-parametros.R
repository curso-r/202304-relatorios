# na linha de comando
# quarto render ~/Documents/Curso-R/cursos/turmas/202304-relatorios/praticas/aula_4/exemplo-apresentacao.qmd

library(quarto)

arquivo_qmd <- "praticas/aula_4/exemplo-apresentacao.qmd"

quarto_render(input = arquivo_qmd)

?quarto_render

quarto_render(input = arquivo_qmd,
              execute_params = list(estado = "AL"))


quarto_render(input = arquivo_qmd,
              execute_params = list(estado = "AL"),
              output_file = "relatorio_barragens_AL.html")


# nome_da_funcao <- function(){
#   # o que a funcao executa
# }

gerar_relatorio_uf <- function(uf_funcao){

  arquivo_html <- glue::glue("praticas/aula_4/relatorio_barragens_{uf_funcao}.html")

  quarto_render(input = arquivo_qmd,
                execute_params = list(estado = uf_funcao),
                # output_file = arquivo_html,
                quiet = TRUE)



  # mover para a pasta desejada
  fs::file_move(
    path = "praticas/aula_4/exemplo-apresentacao.html",
    new_path = arquivo_html
  )

}

gerar_relatorio_uf("PA")

# purrr!
library(purrr)


arquivo_bruto <- readxl::read_excel(here::here("dados/Relatorio_20235918.xlsx"),
                                    skip = 3)

vetor_de_estados <- unique(arquivo_bruto$UF) |> sort()

map(.x = vetor_de_estados,
    .f = gerar_relatorio_uf,
    .progress = TRUE)



beepr::beep()
