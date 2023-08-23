//
//  TermosView.swift
//  macroChallenge
//
//  Created by rebeca primo on 13/06/23.
//

import SwiftUI

struct TermosView: View {
    var body: some View {
        ZStack {
            Image("jogar")
                .resizable()
                .edgesIgnoringSafeArea(.all)
            VStack {
                Spacer() // Empurra o conteúdo para cima
                GeometryReader { geometry in
                    ScrollView {
                        VStack {
                            Text("""
                                Ao baixar ou usar o aplicativo, esses termos serão aplicados automaticamente a você – portanto, certifique-se de lê-los cuidadosamente antes de usar o aplicativo. Você não tem permissão para copiar ou modificar o aplicativo, qualquer parte do aplicativo ou nossas marcas registradas de forma alguma. Você não tem permissão para tentar extrair o código-fonte do aplicativo e também não deve tentar traduzir o aplicativo para outros idiomas ou criar versões derivadas. O aplicativo em si e todas as marcas registradas, direitos autorais, direitos de banco de dados e outros direitos de propriedade intelectual relacionados a ele ainda pertencem ao BCMR.
                                O BCMR está empenhado em garantir que o aplicativo seja o mais útil e eficiente possível. Por esse motivo, nos reservamos o direito de fazer alterações no aplicativo ou cobrar por seus serviços, a qualquer momento e por qualquer motivo. Nunca cobraremos pelo aplicativo ou seus serviços sem deixar bem claro para você exatamente o que você está pagando.
                                O B.O.M.B. app armazena e processa dados pessoais que você nos forneceu para fornecer nosso Serviço. É sua responsabilidade manter seu telefone e acesso ao aplicativo seguros. Portanto, recomendamos que você não faça jailbreak ou root em seu telefone, que é o processo de remoção de restrições e limitações de software impostas pelo sistema operacional oficial do seu dispositivo. Isso pode tornar seu telefone vulnerável a malware/vírus/programas maliciosos, comprometer os recursos de segurança do seu telefone e pode significar que o B.O.M.B. o aplicativo não funcionará corretamente ou não funcionará.
                                Você deve estar ciente de que há certas coisas pelas quais o BCMR não assumirá a responsabilidade. Certas funções do aplicativo exigirão que o aplicativo tenha uma conexão ativa com a Internet. A conexão pode ser Wi-Fi ou fornecida pelo seu provedor de rede móvel, mas o BCMR não pode se responsabilizar pelo aplicativo não funcionar com todas as funcionalidades se você não tiver acesso ao Wi-Fi e não tiver nenhum dos seus dados subsídio deixado.
                                Se você estiver usando o aplicativo fora de uma área com Wi-Fi, lembre-se de que os termos do contrato com sua operadora de rede móvel ainda serão aplicados. Como resultado, você pode ser cobrado por sua operadora de celular pelo custo dos dados durante a conexão durante o acesso ao aplicativo ou outras cobranças de terceiros. Ao usar o aplicativo, você aceita a responsabilidade por tais cobranças, incluindo cobranças de dados de roaming se você usar o aplicativo fora de seu território de origem (ou seja, região ou país) sem desativar o roaming de dados. Se você não for o pagador da conta do dispositivo no qual está usando o aplicativo, saiba que presumimos que você recebeu permissão do pagador para usar o aplicativo.
                                Na mesma linha, o BCMR nem sempre pode assumir a responsabilidade pela maneira como você usa o aplicativo, ou seja, você precisa garantir que seu dispositivo permaneça carregado - se ficar sem bateria e você não puder ligá-lo para aproveitar o serviço, o BCMR não poderá aceitar a responsabilidade.
                                Com relação à responsabilidade do BCMR pelo uso do aplicativo, quando você estiver usando o aplicativo, é importante ter em mente que, embora nos esforcemos para garantir que ele esteja sempre atualizado e correto, contamos com terceiros para fornecer informações para nós para que possamos disponibilizá-las para você. O BCMR não se responsabiliza por qualquer perda, direta ou indireta, que você sofra como resultado de confiar totalmente nessa funcionalidade do aplicativo.
                                Em algum momento, podemos desejar atualizar o aplicativo. O aplicativo está atualmente disponível no iOS - os requisitos para o sistema (e para quaisquer sistemas adicionais para os quais decidimos estender a disponibilidade do aplicativo) podem mudar e você precisará baixar as atualizações se quiser continuar usando o aplicativo . O BCMR não promete que sempre atualizará o aplicativo para que seja relevante para você e/ou funcione com a versão do iOS que você instalou em seu dispositivo. No entanto, você promete sempre aceitar as atualizações do aplicativo quando oferecidas a você. Também podemos interromper o fornecimento do aplicativo e encerrar o uso dele a qualquer momento, sem avisar você. A menos que digamos o contrário, após qualquer rescisão, (a) os direitos e licenças concedidos a você nestes termos terminarão; (b) você deve parar de usar o aplicativo e (se necessário) excluí-lo do seu dispositivo.
                                
                                Alterações nestes Termos e Condições
                                Podemos atualizar nossos Termos e Condições de tempos em tempos. Assim, você é aconselhado a revisar esta página periodicamente para quaisquer alterações. Iremos notificá-lo sobre quaisquer alterações publicando os novos Termos e Condições nesta página.
                                
                                Estes termos e condições são efetivos a partir de 2023-08-02
                                
                                Contate-nos
                                Se você tiver alguma dúvida ou sugestão sobre nossos Termos e Condições, não hesite em nos contatar em bomb.bcmr@gmail.com.
                                """)
                            .multilineTextAlignment(.leading)
                            .font(.custom("SpecialElite-Regular", size: 20))
                        }
                    }
                    .padding(.top, 100)
                    .padding(.horizontal, 5)
                    .padding(.leading, 30)
                    .padding(.trailing, 30)
                    .foregroundColor(.black)
                }
                Spacer()
            }
        }
        .navigationTitle("Termos de uso")
        .navigationBarTitleDisplayMode(.inline)
    }
}
