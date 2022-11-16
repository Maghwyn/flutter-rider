RegExp emailFormat = RegExp(
  r"^(?=.{2,42}@)[0-9a-zA-Z]+(?:[+\.-][0-9a-z]+)*@((?=.{3,64}$)[a-z0-9]{1,}(?:-{1,3}[a-z]{1,})?(?:\.[a-z]{0})?)+(?:[a-z]{1,}\.[a-z]{2,})(?!.)+",
  caseSensitive: false,
  multiLine: false,
);