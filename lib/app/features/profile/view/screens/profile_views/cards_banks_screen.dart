import 'package:floatr/app/extensions/padding.dart';
import 'package:floatr/app/extensions/sized_context.dart';
import 'package:floatr/app/features/loan/providers/loan_provider.dart';
import 'package:floatr/core/providers/base_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/utils/app_style.dart';
import '../../../../../../core/utils/images.dart';
import '../../../../../../core/utils/spacing.dart';
import '../../../../../widgets/app_text.dart';
import '../../../../../widgets/custom_appbar.dart';
import '../../../../../widgets/general_button.dart';
import '../../../../../widgets/pageview_toggler.dart';
import '../../../../loan/view/screens/loan_info_screen.dart';

class CardsBanksScreen extends StatelessWidget {
  const CardsBanksScreen({
    super.key,
    required this.togglePosition,
  });

  final TogglePosition togglePosition;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Profile',
        useInAppArrow: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: SizedBox(
          width: context.widthPx,
          child: CardsBanksScreenHolder(
            togglePosition: togglePosition,
          ),
        ),
      ),
    );
  }
}

class CardsBanksArguments {
  CardsBanksArguments({required this.togglePosition});
  final TogglePosition togglePosition;
}

class CardsBanksScreenHolder extends StatefulWidget {
  const CardsBanksScreenHolder({
    Key? key,
    required this.togglePosition,
  }) : super(key: key);

  final TogglePosition togglePosition;

  @override
  State<CardsBanksScreenHolder> createState() => _CardsBanksScreenHolderState();
}

class _CardsBanksScreenHolderState extends State<CardsBanksScreenHolder> {
  late TogglePosition togglePosition;

  @override
  void initState() {
    togglePosition = widget.togglePosition;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const VerticalSpace(
          size: 20,
        ),
        InkWell(
            onTap: () => setState(() {
                  togglePosition = toggle;
                }),
            child: PageViewToggler(
              togglePosition: togglePosition,
              viewName: const ['Cards', 'Banks'],
            )),
        const VerticalSpace(
          size: 24,
        ),
        togglePosition == TogglePosition.left
            ? const CardView()
            : const BanksView()
      ],
    );
  }

  TogglePosition get toggle => togglePosition == TogglePosition.left
      ? TogglePosition.right
      : TogglePosition.left;
}

class BanksView extends StatelessWidget {
  const BanksView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const VerticalSpace(
          size: 30,
        ),

        SizedBox(
          height: context.heightPx * 0.55,
          child: Consumer<LoanProvider>(builder: (context, loanProvider, _) {
            final banks = loanProvider.myBanksResponse == null
                ? []
                : loanProvider.myBanksResponse!.mybanks;
            switch (loanProvider.loadingState) {
              case LoadingState.busy:
                return const Center(
                  child: CircularProgressIndicator.adaptive(),
                );
              case LoadingState.loaded:
                // if (banks.isEmpty) {
                //   return const NoBanksView();
                // }
                return ListView.builder(
                    itemCount: 2,
                    itemBuilder: (context, index) => SelectBank(
                          color: AppColors.lightGrey300,
                          bankName: banks[index].bank.name,
                          bankNumber: banks[index].accountNo,
                          isDefault: banks[index].isDefault,
                        ).paddingOnly(bottom: 20));

              case LoadingState.error:
                return Center(
                  child: Text(
                    '''An Unexpected error occured!''',
                    style: TextStyles.normalTextDarkF800,
                  ),
                );
              default:
                return const NoBanksView();
            }
          }),
        ),

        // bottom
        GeneralButton(
          height: 42,
          onPressed: () {},
          borderRadius: 8,
          child: const AppText(
            text: 'ADD NEW BANK',
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        )
      ],
    );
  }
}

class NoBanksView extends StatelessWidget {
  const NoBanksView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // error image
        Container(
          height: 131,
          width: 127,
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(AppImages.walletSad), fit: BoxFit.cover),
          ),
        ),

        const VerticalSpace(
          size: 53,
        ),

        // error text
        Text(
          '''No Banks Yet''',
          style: TextStyles.normalTextDarkF800,
        ),

        const VerticalSpace(
          size: 17,
        ),

        // comple profile text
        Text(
          '''Add a new bank to see all your banks here.''',
          style: TextStyles.smallTextGrey,
        ),

        const VerticalSpace(
          size: 35,
        ),
      ],
    );
  }
}

class CardView extends StatelessWidget {
  const CardView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const VerticalSpace(
          size: 30,
        ),

        SizedBox(
          height: context.heightPx * 0.55,
          child: Consumer<LoanProvider>(builder: (context, loanProvider, _) {
            final cards = loanProvider.myCardsResponse == null
                ? []
                : loanProvider.myCardsResponse!;
            switch (loanProvider.loadingState) {
              case LoadingState.busy:
                return const Center(
                  child: CircularProgressIndicator.adaptive(),
                );
              case LoadingState.loaded:
                // if (cards.isEmpty) {
                //   return const NoBanksView();
                // }
                return ListView.builder(
                    itemCount: 3,
                    itemBuilder: (context, index) =>
                        const DebitCard().paddingOnly(bottom: 20));

              case LoadingState.error:
                return const NoBanksView();
              default:
                return const NoBanksView();
            }
          }),
        ),

        const VerticalSpace(size: 30,),

        // bottom
        GeneralButton(
          height: 42,
          onPressed: () {},
          borderRadius: 8,
          child: const AppText(
            text: 'ADD NEW CARD',
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        )
      ],
    );
  }
}

class NoCardsView extends StatelessWidget {
  const NoCardsView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // error image
        Container(
          height: 131,
          width: 127,
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(AppImages.walletSad), fit: BoxFit.cover),
          ),
        ),

        const VerticalSpace(
          size: 53,
        ),

        // error text
        Text(
          '''No Cards Yet''',
          style: TextStyles.normalTextDarkF800,
        ),

        const VerticalSpace(
          size: 17,
        ),

        // comple profile text
        Text(
          '''Add a new card to see all your cards here.''',
          style: TextStyles.smallTextGrey,
        ),
      ],
    );
  }
}
